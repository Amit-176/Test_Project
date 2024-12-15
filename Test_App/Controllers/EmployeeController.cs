using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Test_App.Data;
using Test_App.Models;

namespace Test_App.Controllers
{
    public class EmployeeController : Controller
    {
        private readonly ApplicationDbContext _context;

        public EmployeeController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var employees = await _context.Employees
                .Include(e => e.EmployeeProjects)
                .ThenInclude(ep => ep.Project)
                .ToListAsync();
            return View(employees);
        }

        // Upsert method for Employee
        public async Task<IActionResult> Upsert(int? id)
        {
            var employee = new Employee();
            var viewModel = new EmployeeViewModel
            {
                Projects = await _context.Projects
                    .Select(p => new SelectListItem
                    {
                        Value = p.Id.ToString(),
                        Text = p.Name
                    }).ToListAsync()
            };

            if (id.HasValue)
            {
                employee = await _context.Employees
                    .Include(e => e.EmployeeProjects)
                    .ThenInclude(ep => ep.Project)
                    .FirstOrDefaultAsync(e => e.Id == id.Value);

                if (employee == null)
                {
                    return NotFound();
                }
            }

            viewModel.Employee = employee;
            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Upsert(EmployeeViewModel viewModel, int[] selectedProjects)
            {
            if (!ModelState.IsValid)
            {
                if (viewModel.Employee.Id > 0) // Updating existing employee
                {
                    // Fetch the existing employee
                    var existingEmployee = await _context.Employees
                        .Include(e => e.EmployeeProjects)
                        .FirstOrDefaultAsync(e => e.Id == viewModel.Employee.Id);

                    if (existingEmployee == null)
                    {
                        return NotFound();
                    }

                    // Update employee properties
                    existingEmployee.FirstName = viewModel.Employee.FirstName;
                    existingEmployee.LastName = viewModel.Employee.LastName;
                    existingEmployee.DOB = viewModel.Employee.DOB;
                    existingEmployee.Gender = viewModel.Employee.Gender;

                    // Clear existing projects and add selected ones
                    existingEmployee.EmployeeProjects.Clear();

                    if (selectedProjects != null && selectedProjects.Length > 0)
                    {
                        foreach (var projectId in selectedProjects)
                        {
                            existingEmployee.EmployeeProjects.Add(new EmployeeProject
                            {
                                EmployeeId = existingEmployee.Id,
                                ProjectId = projectId
                            });
                        }
                    }

                    _context.Update(existingEmployee);
                }
                else // Creating new employee
                {
                    // Add the new employee
                    _context.Add(viewModel.Employee);
                    await _context.SaveChangesAsync();

                    // Associate selected projects
                    if (selectedProjects != null && selectedProjects.Length > 0)
                    {
                        foreach (var projectId in selectedProjects)
                        {
                            _context.EmployeeProjects.Add(new EmployeeProject
                            {
                                EmployeeId = viewModel.Employee.Id,
                                ProjectId = projectId
                            });
                        }
                    }
                }

                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            // Repopulate projects if validation fails
            viewModel.Projects = await _context.Projects
                .Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Name
                }).ToListAsync();

            return View(viewModel);
        }

        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var employee = await _context.Employees
                .Include(e => e.EmployeeProjects)
                .ThenInclude(ep => ep.Project)
                .FirstOrDefaultAsync(e => e.Id == id);

            if (employee == null)
            {
                return NotFound();
            }

            return View(employee);
        }

        // POST: Employees/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(int id)
        {
            var employee = await _context.Employees.FindAsync(id);
            if (employee != null)
            {
                _context.Employees.Remove(employee);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }

        private bool EmployeeExists(int id)
        {
            return _context.Employees.Any(e => e.Id == id);
        }
    }
}
