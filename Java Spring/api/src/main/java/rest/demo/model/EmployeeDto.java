package rest.demo.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;


@Getter
@Setter
@AllArgsConstructor
public class EmployeeDto {
    private String firstname;
    private String lastname;
    private boolean active;
    private LocalDate created;

    public  static Employee mapToEmployee(EmployeeDto employeeDto,Long id) {
        return new Employee(
                id,
                employeeDto.getFirstname(),
                employeeDto.getLastname(),
                employeeDto.isActive(),
                employeeDto.getCreated()
        );
    }

    public static EmployeeDto mapToEmployeeDto(Employee employee){
        return new EmployeeDto(
                employee.getFirstname(),
                employee.getLastname(),
                employee.isActive(),
                employee.getCreated()
        );
    }

    public static Employee mapToDeactivateEmployee(EmployeeDto employeeDto,Long id){
        if(employeeDto.isActive()) employeeDto.setActive(false);
        return employeeFromDto(employeeDto,id);
    }

    public static Employee mapToActivateEmployee(EmployeeDto employeeDto, Long id){
        if(!employeeDto.isActive()) employeeDto.setActive(true);
        return employeeFromDto(employeeDto,id);
    }

    private static Employee employeeFromDto(EmployeeDto employeeDto, Long id){
        return new Employee(
                id,
                employeeDto.getFirstname(),
                employeeDto.getLastname(),
                employeeDto.isActive(),
                employeeDto.getCreated()
        );
    }
}


