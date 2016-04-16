package io.pivotal.workshop.questrade;

import io.pivotal.workshop.questrade.CustomerServiceApplication;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = CustomerServiceApplication.class)
@WebAppConfiguration
public class CustomerServiceApplicationTests {

	@Test
	public void contextLoads() {
	}

}
