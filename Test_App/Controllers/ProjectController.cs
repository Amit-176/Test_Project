using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Test_App.Models;
using Test_App.Data;
namespace Test_App.Controllers
{
    public class ProjectController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ProjectController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var projects = await _context.Projects
                .Include(p => p.EmployeeProjects)
                .ThenInclude(ep => ep.Employee)
                .ToListAsync();
            return View(projects);
        }

        // Upsert method for Project (Create or Edit)
        public async Task<IActionResult> Upsert(int? id)
        {
            var project = new Project();
            var viewModel = new ProjectViewModel
            {
                Employees = await _context.Employees
                    .Select(e => new SelectListItem
                    {
                        Value = e.Id.ToString(),
                        Text = e.FirstName+""+e.LastName
                    }).ToListAsync()
            };

            if (id.HasValue)
            {
                project = await _context.Projects
                    .Include(p => p.EmployeeProjects)
                    .ThenInclude(ep => ep.Employee)
                    .FirstOrDefaultAsync(p => p.Id == id.Value);

                if (project == null)
                {
                    return NotFound();
                }
            }

            viewModel.Project = project;
            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Upsert(ProjectViewModel viewModel, int[] selectedEmployees)
        {
            if (!ModelState.IsValid)
            {
                if (viewModel.Project.Id > 0) // Updating existing project
                {
                    var existingProject = await _context.Projects
                        .Include(p => p.EmployeeProjects)
                        .FirstOrDefaultAsync(p => p.Id == viewModel.Project.Id);

                    if (existingProject == null)
                    {
                        return NotFound();
                    }

                    // Update project properties
                    existingProject.Name = viewModel.Project.Name;
                    existingProject.Description = viewModel.Project.Description;
                    existingProject.StartDate = viewModel.Project.StartDate;
                    existingProject.EndDate = viewModel.Project.EndDate;

                    // Clear existing employee associations and add new ones
                    existingProject.EmployeeProjects.Clear();

                    if (selectedEmployees != null && selectedEmployees.Length > 0)
                    {
                        foreach (var employeeId in selectedEmployees)
                        {
                            existingProject.EmployeeProjects.Add(new EmployeeProject
                            {
                                ProjectId = existingProject.Id,
                                EmployeeId = employeeId
                            });
                        }
                    }

                    _context.Update(existingProject);
                }
                else // Creating new project
                {
                    _context.Add(viewModel.Project);
                    await _context.SaveChangesAsync();

                    if (selectedEmployees != null && selectedEmployees.Length > 0)
                    {
                        foreach (var employeeId in selectedEmployees)
                        {
                            _context.EmployeeProjects.Add(new EmployeeProject
                            {
                                ProjectId = viewModel.Project.Id,
                                EmployeeId = employeeId
                            });
                        }
                    }
                }

                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            // Repopulate employees if validation fails
            viewModel.Employees = await _context.Employees
                .Select(e => new SelectListItem
                {
                    Value = e.Id.ToString(),
                    Text = e.FirstName + " " + e.LastName
                }).ToListAsync();

            return View(viewModel);
        }

        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var project = await _context.Projects
                .Include(p => p.EmployeeProjects)
                .ThenInclude(ep => ep.Employee)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (project == null)
            {
                return NotFound();
            }

            return View(project);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(int id)
        {
            var project = await _context.Projects.FindAsync(id);
            if (project != null)
            {
                _context.Projects.Remove(project);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }

        private bool ProjectExists(int id)
        {
            return _context.Projects.Any(p => p.Id == id);
        }
    }
}
