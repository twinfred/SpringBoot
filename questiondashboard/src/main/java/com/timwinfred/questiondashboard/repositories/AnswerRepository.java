package com.timwinfred.questiondashboard.repositories;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.questiondashboard.models.Answer;

public interface AnswerRepository extends CrudRepository<Answer, Long> {
	
}
