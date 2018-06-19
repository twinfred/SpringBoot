package com.timwinfred.questiondashboard.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.questiondashboard.models.Tag;
import com.timwinfred.questiondashboard.repositories.TagRepository;

@Service
public class TagService {
	private final TagRepository tagRepository;
	
	public TagService(TagRepository tagRepository) {
		this.tagRepository = tagRepository;
	}
	
	// get all tags
	public List<Tag> getAllTags() {
		return tagRepository.findAll();
	}
	
	// get a single tag
	public Tag getTag(Long id) {
		Optional<Tag> optionalTag = tagRepository.findById(id);
		if(optionalTag.isPresent()) {
			return optionalTag.get();
		} else {
			return null;
		}
	}
	
	// get a single tag by a name
	public Tag getTagByName(String name) {
		return tagRepository.findByName(name);
	}
	
	// create a tag
	public Tag createTag(Tag tag) {
		return tagRepository.save(tag);
	}
}
