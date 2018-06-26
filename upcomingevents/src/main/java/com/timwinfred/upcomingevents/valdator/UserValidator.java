package com.timwinfred.upcomingevents.valdator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.timwinfred.upcomingevents.models.User;

@Component
public class UserValidator implements Validator {
	@Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }
    
    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;
        if (!user.getPassConf().equals(user.getPassword())) {
            errors.rejectValue("passConf", "Match");
        }         
    }
}
