using Microsoft.AspNetCore.Mvc.Rendering;

namespace Test_App.Models
{
    public class EmployeeViewModel
    {
        public Employee Employee { get; set; } // Employee object
        public int? SelectedProjectId { get; set; }  // Holds the selected project ID from the dropdown
        public List<SelectListItem> Projects { get; set; }  // List of available projects for the dropdown
    }
}
