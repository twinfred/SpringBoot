package com.timwinfred.questiondashboard.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.questiondashboard.models.Tag;

public interface TagRepository extends CrudRepository<Tag, Long> {
	List<Tag> findAll();
	Tag findByName(String name);
}
