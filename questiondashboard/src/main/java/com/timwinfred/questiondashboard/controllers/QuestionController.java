package com.timwinfred.questiondashboard.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.timwinfred.questiondashboard.models.Answer;
import com.timwinfred.questiondashboard.models.Question;
import com.timwinfred.questiondashboard.models.Tag;
import com.timwinfred.questiondashboard.services.AnswerService;
import com.timwinfred.questiondashboard.services.QuestionService;
import com.timwinfred.questiondashboard.services.TagService;

@Controller
@RequestMapping("/questions")
public class QuestionController {
	public final QuestionService questionService;
	public final TagService tagService;
	public final AnswerService answerService;
	
	public QuestionController(QuestionService questionService, TagService tagService, AnswerService answerService) {
		this.questionService = questionService;
		this.tagService = tagService;
		this.answerService = answerService;
	}
	
	// question dashboard
	@RequestMapping("")
	public String questionDashboard(Model model) {
		List<Question> questions = questionService.getAllQuestions();
		model.addAttribute("questions", questions);
		return "dashboard.jsp";
	}
	
	// add a new question (with tags) page
	@RequestMapping("/new")
	public String newQuestion() {
		return "newquestion.jsp";
	}
	
	// add a new question (with tags) POST request
	@RequestMapping(value = "/new", method=RequestMethod.POST)
	public String addQuestion(@RequestParam("question") String question, @RequestParam("tags") String tags) {
		Question myQuestion = new Question(question);
		String[] tagsArray = tags.split(",");
		if(tagsArray.length > 3) {
			return "redirect:/questions/new";
		}
		List<Tag> dbTags = tagService.getAllTags();
		ArrayList<String> dbTagsArray = new ArrayList<String>();
		for(Tag tag:dbTags) {
			dbTagsArray.add(tag.getname());
		}
		List<Tag> myTags = new ArrayList<Tag>();
		for(int i = 0; i < tagsArray.length; i++) {
			tagsArray[i] = tagsArray[i].trim();
			if(dbTagsArray.contains(tagsArray[i])) {
				Tag existingTag = tagService.getTagByName(tagsArray[i]);
				myTags.add(existingTag);
			} else {
				Tag tag = new Tag(tagsArray[i]);
				Tag newTag = tagService.createTag(tag);
				myTags.add(newTag);
			}
		}
		myQuestion.setTags(myTags);
		questionService.createQuestion(myQuestion);
		return "redirect:/questions/" + myQuestion.getId();
	}
	
	// question page
	@RequestMapping("/{id}")
	public String question(@PathVariable(value="id", required=true) Long id, Model model, @ModelAttribute Answer answer) {
		Question question = questionService.getQuestion(id);
		model.addAttribute("question", question);
		model.addAttribute("answers", question.getAnswers());
		model.addAttribute("tags", question.getTags());
		return "question.jsp";
	}
	
	// add answer POST request
	@RequestMapping(value="/answer/{id}",method=RequestMethod.POST)
	public String addAnswer(@PathVariable(value="id", required=true) Long id, @RequestParam("answer") String answer, Model model) {
		Question question = questionService.getQuestion(id);
		Answer newAnswer = new Answer(answer, question);
		answerService.createAnswer(newAnswer);
		return "redirect:/questions/"+id;
	}
}
