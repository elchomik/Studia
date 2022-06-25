package rest.demo.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import rest.demo.model.Employee;
import rest.demo.model.EmployeeDto;
import rest.demo.service.EmployeeService;

import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;
import static rest.demo.model.EmployeeDto.mapToEmployee;


@RestController
@RequiredArgsConstructor
public class EmployeeController {

    public final EmployeeService employeeService;

    @GetMapping("/employees")
    public CollectionModel<EntityModel<Employee>> getEmployees(){
        List<EntityModel<Employee>> employees=employeeService.getEmployees().stream()
                .map(employee -> EntityModel.of(employee,
                        linkTo(methodOn(EmployeeController.class).getEmployee(employee.getId())).withSelfRel(),
                        linkTo(methodOn(EmployeeController.class).getEmployees()).withRel("employees")
                        ))
                .toList();
        return CollectionModel.of(employees,
                linkTo(methodOn(EmployeeController.class).getEmployees()).withSelfRel());
    }

    @GetMapping("/employees/{id}")
    public EntityModel<Employee> getEmployee(@PathVariable Long id){
        return EntityModel.of(employeeService.getEmployee(id),
                linkTo(methodOn(EmployeeController.class).getEmployee(id)).withSelfRel(),
                linkTo(methodOn(EmployeeController.class).getEmployees()).withRel("employees"),
                linkTo(EmployeeController.class).slash("/employees").slash(id).slash("deactivate").withRel("deactivate"),
                linkTo(EmployeeController.class).slash("/employees").slash(id).slash("/activate").withRel("activate"));
    }

    @PostMapping("/employees")
    public ResponseEntity<EntityModel<Employee>> createEmployee(@RequestBody EmployeeDto employeeDto){
        Employee employee=employeeService.createEmployee(mapToEmployee(employeeDto,null));

        UriComponents uriComponents= UriComponentsBuilder.fromHttpUrl(
                "http://localhost:8080/employee/{id}"
        ).buildAndExpand(employee.getId());
        return ResponseEntity.created(uriComponents.toUri()).body(
                EntityModel.of(employee,
                        linkTo(methodOn(EmployeeController.class).createEmployee(employeeDto)).withSelfRel(),
                        linkTo(methodOn(EmployeeController.class).getEmployees()).withRel("employees")));
    }

    @PutMapping("/employees/{id}")
    public Employee updateEmployee(@PathVariable Long id,@RequestBody EmployeeDto employeeDto){
        return employeeService.updateEmployee(mapToEmployee(employeeDto,id));
    }

    @DeleteMapping("/employees/{id}")
    public void deleteEmployee(@PathVariable Long id){
        employeeService.deleteEmployee(id);
    }

    @PutMapping("/employees/{employeeId}/deactivate")
    public ResponseEntity<Employee> deactivateEmployee(@PathVariable Long employeeId){
       Employee employee= employeeService.deactivateEmployee(employeeId);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/employees/{employeeId}/activate")
    public ResponseEntity<Employee> activateEmployee(@PathVariable Long employeeId){
        Employee employee=employeeService.activateEmployee(employeeId);
        return ResponseEntity.noContent().build();
    }
}
