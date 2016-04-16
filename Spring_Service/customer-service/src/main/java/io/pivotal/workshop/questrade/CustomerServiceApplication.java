package io.pivotal.workshop.questrade;

import io.pivotal.workshop.questrade.model.Customer;
import io.pivotal.workshop.questrade.repo.CustomerRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class CustomerServiceApplication {
	
	private static final Logger log = LoggerFactory.getLogger(CustomerServiceApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(CustomerServiceApplication.class, args);
	}
	
	@Bean
	public CommandLineRunner demo(CustomerRepository repository) {
		return (args) -> {
			
			//clean up old
			repository.deleteAll();
			
			// save a couple of customers
			repository.save(new Customer(1, "Dan", "Buchko"));
			repository.save(new Customer(2, "Luke", "Shannon"));
			repository.save(new Customer(3, "David 'Maniac'", "Barry"));
			repository.save(new Customer(4, "Louis", "Lo"));

			// fetch all customers
			log.info("Customers found with findAll():");
			log.info("-------------------------------");
			for (Customer customer : repository.findAll()) {
				log.info(customer.toString());
			}
            log.info("");

			// fetch customers by last name
			log.info("Customer found with findByLastName('Lo'):");
			log.info("--------------------------------------------");
			for (Customer bauer : repository.findByLastName("Lo")) {
				log.info(bauer.toString());
			}
            log.info("");
		};
	}
}
