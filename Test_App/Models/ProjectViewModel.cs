using Microsoft.AspNetCore.Mvc.Rendering;
namespace Test_App.Models
{
    public class ProjectViewModel
    {
        public Project Project { get; set; } // Employee object
        public int? SelectedEmployeeId { get; set; }  // Holds the selected project ID from the dropdown
        public List<SelectListItem> Employees { get; set; }  // List of available projects for the dropdown
    }
}