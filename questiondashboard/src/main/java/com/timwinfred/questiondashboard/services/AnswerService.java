package com.timwinfred.questiondashboard.services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.questiondashboard.models.Answer;
import com.timwinfred.questiondashboard.models.Question;
import com.timwinfred.questiondashboard.repositories.AnswerRepository;
import com.timwinfred.questiondashboard.repositories.QuestionRepository;

@Service
public class AnswerService {
	public final AnswerRepository answerRepository;
	public final QuestionRepository questionRepository;
	
	public AnswerService(AnswerRepository answerRepository, QuestionRepository questionRepository) {
		this.answerRepository = answerRepository;
		this.questionRepository = questionRepository;
	}
	
	// create an answer
	public Answer createAnswer(Answer answer) {
		return answerRepository.save(answer);
	}
	
	// add question to answer
	public Answer addQuestionToAnswer(Long answerId, Long questionId) {
		Optional<Answer> optionalAnswer = answerRepository.findById(answerId);
		if(optionalAnswer.isPresent()) {
			Answer answer = optionalAnswer.get();
			Optional<Question> optionalQuestion = questionRepository.findById(questionId);
			if(optionalQuestion.isPresent()) {
				Question question = optionalQuestion.get();
				answer.setQuestion(question);
				return answer;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}
