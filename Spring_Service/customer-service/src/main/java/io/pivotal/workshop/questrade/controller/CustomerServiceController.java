package io.pivotal.workshop.questrade.controller;

import io.pivotal.workshop.questrade.model.Customer;
import io.pivotal.workshop.questrade.repo.CustomerRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CustomerServiceController {

	Logger logger = LoggerFactory
			.getLogger(CustomerServiceController.class);

	@Autowired
	private CustomerRepository customerRepo;
	
	@RequestMapping("/")
	public Iterable<Customer> getCustomers() {
		
		Iterable<Customer> customers = customerRepo.findAll();
		return customers;
		
	}
	
}
