package com.timwinfred.magicreviewer.repositories;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.magicreviewer.models.Card;

public interface CardRepository extends CrudRepository<Card, Long> {
	Card findByName(String name);
}
