package io.pivotal.workshop.questrade.repo;

import io.pivotal.workshop.questrade.model.Customer;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;


@RepositoryRestResource(collectionResourceRel = "customer", path = "customers")
public interface CustomerRepository extends CrudRepository<Customer, Long> {

	List<Customer> findByLastName(@Param("lastName") String lastName);


}
