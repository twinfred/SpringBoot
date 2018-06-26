package com.timwinfred.magicreviewer.services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.magicreviewer.models.Card;
import com.timwinfred.magicreviewer.repositories.CardRepository;

@Service
public class CardService {
	private final CardRepository cardRepository;

	public CardService(CardRepository cardRepository) {
		this.cardRepository = cardRepository;
	}
	
	public Card createCard(Card card) {
		return cardRepository.save(card);
	}
	
	public Card getCardByName(String name) {
		return this.cardRepository.findByName(name);
	}
	
	public Card getCardById(Long id) {
		Optional<Card> card = cardRepository.findById(id);
		if(card.isPresent()) {
			return card.get();
		} else {
			return null;
		}
	}
}
