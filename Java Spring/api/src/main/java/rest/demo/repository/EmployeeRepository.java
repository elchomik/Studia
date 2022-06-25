package rest.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import rest.demo.model.Employee;

public interface EmployeeRepository extends JpaRepository<Employee,Long> {
}
