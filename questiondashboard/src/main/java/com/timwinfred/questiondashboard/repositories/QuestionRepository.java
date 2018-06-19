package com.timwinfred.questiondashboard.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.questiondashboard.models.Question;

public interface QuestionRepository extends CrudRepository<Question, Long> {
	List<Question> findAll();
}
