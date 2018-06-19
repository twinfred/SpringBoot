package com.timwinfred.questiondashboard.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.questiondashboard.models.Question;
import com.timwinfred.questiondashboard.models.Tag;
import com.timwinfred.questiondashboard.repositories.QuestionRepository;
import com.timwinfred.questiondashboard.repositories.TagRepository;

@Service
public class QuestionService {
	public final QuestionRepository questionRepository;
	public final TagRepository tagRepository;

	public QuestionService(QuestionRepository questionRepository, TagRepository tagRepository) {
		this.questionRepository = questionRepository;
		this.tagRepository = tagRepository;
	}

	// get all questions
	public List<Question> getAllQuestions() {
		return questionRepository.findAll();
	}
	
	// get a single question
	public Question getQuestion(Long id) {
		Optional<Question> optionalQuestion = questionRepository.findById(id);
		if(optionalQuestion.isPresent()) {
			return optionalQuestion.get();
		} else {
			return null;
		}
	}
	
	// create a question
	public Question createQuestion(Question question) {
		return questionRepository.save(question);
	}
	
	// add a tag to a question
	public Question addTagToQuestion(Long questionId, Long tagId) {
		Optional<Question> optionalQuestion = questionRepository.findById(questionId);
		if(optionalQuestion.isPresent()) {
			Optional<Tag> optionalTag = tagRepository.findById(tagId);
			if(optionalTag.isPresent()) {
				Question myQuestion = optionalQuestion.get();
				Tag myTag = optionalTag.get();
				myQuestion.addTag(myTag);
				return questionRepository.save(myQuestion);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}
