package io.pivotal.devops;


import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class CustomerServiceApplication {

	private static final Logger log = LoggerFactory
			.getLogger(CustomerServiceApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(CustomerServiceApplication.class, args);

	}

	@Bean
	public CommandLineRunner demo(CustomerRepository repository) {
		return (args) -> {

			// clean up old
			repository.deleteAll();

			// save a couple of customers
			repository.save(new Customer(1, "Dan", "Buchko"));
			repository.save(new Customer(2, "Josh", "Long"));
			repository.save(new Customer(3, "Luke", "Shannon"));
			repository.save(new Customer(4, "Ben", "Berkta"));
			repository.save(new Customer(5, "James", "Weaver" ));
			repository.save(new Customer(6, "Louis", "Lo"));

			// For testing
			// fetch all the customers
			log.info("Customers found with findAll():");
			log.info("-------------------------------");
			for (Customer customer : repository.findAll()) {
				log.info(customer.toString());
			}
			log.info("");

			// demo fetch customers by last name
			log.info("Customer found with findByLastName('Long'):");
			log.info("--------------------------------------------");
			for (Customer bauer : repository.findByLastName("Long")) {
				log.info(bauer.toString());
			}
			log.info("");
		};
	}


}

@Component
interface CustomerRepository extends CrudRepository<Customer, Long> {

	List<Customer> findByLastName(@Param("lastName") String lastName);

}

@CrossOrigin
@RestController
class CustomerController {
	@Autowired
	CustomerRepository customerRepo;

	@RequestMapping("/")
	Iterable<Customer> getCustomers() {

		Iterable<Customer> customers = customerRepo.findAll();
		return customers;

	}
}

@Entity
class Customer {

	@Id
    private long id;
    private String firstName;
    private String lastName;

    public Customer() {}

    public Customer(long id, String firstName, String lastName) {
    	this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    @Override
    public String toString() {
        return String.format(
                "Customer[id=%d, firstName='%s', lastName='%s']",
                id, firstName, lastName);
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
    
    
}

