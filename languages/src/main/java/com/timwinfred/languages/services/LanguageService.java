package com.timwinfred.languages.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.languages.models.Language;
import com.timwinfred.languages.repositories.LanguageRepository;

@Service
public class LanguageService {
	private final LanguageRepository languageRepository;
	
	public LanguageService(LanguageRepository languageRepository) {
		this.languageRepository = languageRepository;
	}
	
	//returns all languages
	public List<Language> allLanguages() {
		return languageRepository.findAll();
	}
	
	//create a language
	public Language createLanguage(Language language) {
		return languageRepository.save(language);
	}
	
	//retrieves a single language
	public Language findLanguage(Long id) {
		Optional<Language> optionalLanguage = languageRepository.findById(id);
		if(optionalLanguage.isPresent()) {
			return optionalLanguage.get();
		} else {
			return null;
		}
	}
	
	// deletes a language
	public void deleteLanguage(Long id) {
		Optional<Language> optionalLanguage = languageRepository.findById(id);
		if(optionalLanguage.isPresent()) {
			languageRepository.deleteById(id);
			return;
		} else {
			return;
		}
	}
	
	// updates a language
	public Language updateLanguage(Long id, String name, String creator, String version) {
		Optional<Language> optionalLanguage = languageRepository.findById(id);
		if(optionalLanguage.isPresent()) {
			Language language = optionalLanguage.get();
			language.setName(name);
			language.setCreator(creator);
			language.setVersion(version);
			return languageRepository.save(language);
		} else {
			return null;
		}
	}
}
