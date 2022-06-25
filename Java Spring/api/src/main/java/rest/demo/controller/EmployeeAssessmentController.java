package rest.demo.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import rest.demo.model.EmployeeAssesment;

@RestController
public class EmployeeAssessmentController {
    @PutMapping("/employees/{employeeId}/assessments/{assessmentId}")
    public EmployeeAssesment updateEmployeeAssessment(@PathVariable Long employeeId,@PathVariable Long assessmentId){
        return null;
    }
}
