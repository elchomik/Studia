package rest.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import rest.demo.model.Employee;
import rest.demo.model.EmployeeDto;
import rest.demo.repository.EmployeeRepository;

import java.util.List;
import java.util.Optional;

import static rest.demo.model.EmployeeDto.*;

@Service
@RequiredArgsConstructor
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public List<Employee> getEmployees(){
        return employeeRepository.findAll();
    }

    public Employee getEmployee(Long id) {
        return employeeRepository.findById(id).orElseThrow();
    }

    public Employee createEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    public Employee updateEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    public void deleteEmployee(Long id) {
        employeeRepository.deleteById(id);
    }

    public Employee deactivateEmployee(Long employeeId) {
        EmployeeDto employeeDto=mapToEmployeeDto(employeeRepository.findById(employeeId).orElseThrow());
        Employee deactivateEmployee=mapToDeactivateEmployee(employeeDto,employeeId);
        employeeRepository.save(deactivateEmployee);
        return deactivateEmployee;
    }

    public Employee activateEmployee(Long employeeId) {
        EmployeeDto employeeDto=mapToEmployeeDto(employeeRepository.findById(employeeId).orElseThrow());
        Employee activateEmployee=mapToActivateEmployee(employeeDto,employeeId);
        employeeRepository.save(activateEmployee);
        return activateEmployee;
    }
}
