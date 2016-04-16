package io.pivotal.devops.repo;

import io.pivotal.devops.model.Customer;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface CustomerRepository extends CrudRepository<Customer, Long> {

	List<Customer> findByLastName(@Param("lastName") String lastName);


}
