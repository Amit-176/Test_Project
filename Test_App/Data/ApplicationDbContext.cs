using Microsoft.EntityFrameworkCore;
using Test_App.Models;

namespace Test_App.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

            public DbSet<Employee> Employees { get; set; }
            public DbSet<Project> Projects { get; set; }
            public DbSet<EmployeeProject> EmployeeProjects { get; set; }

            protected override void OnModelCreating(ModelBuilder modelBuilder)
            {
                // Many-to-Many relationship configuration
                modelBuilder.Entity<EmployeeProject>()
                    .HasKey(ep => new { ep.EmployeeId, ep.ProjectId });

                modelBuilder.Entity<EmployeeProject>()
                    .HasOne(ep => ep.Employee)
                    .WithMany(e => e.EmployeeProjects)
                    .HasForeignKey(ep => ep.EmployeeId);

                modelBuilder.Entity<EmployeeProject>()
                    .HasOne(ep => ep.Project)
                    .WithMany(p => p.EmployeeProjects)
                    .HasForeignKey(ep => ep.ProjectId);
            }

    }
}
