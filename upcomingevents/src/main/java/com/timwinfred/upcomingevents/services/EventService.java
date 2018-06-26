package com.timwinfred.upcomingevents.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.timwinfred.upcomingevents.models.Event;
import com.timwinfred.upcomingevents.repositories.EventRepository;

@Service
public class EventService {
	private final EventRepository eventRepository;

	public EventService(EventRepository eventRepository) {
		this.eventRepository = eventRepository;
	}
	
	// create an event
	public Event createEvent(Event event) {
		return eventRepository.save(event);
	}
	
	// get all events in user's state
	public List<Object[]> getEventsInState(String state) {
		return eventRepository.findAllEventsInUserState(state);
	}
	
	// get all events in user's state
	public List<Object[]> getEventsOutOfState(String state) {
		return eventRepository.findAllEventsNotInUserState(state);
	}
	
	// get user rsvps
	public List<Object[]> getUserRsvps(Long id) {
		return eventRepository.findUserRsvps(id);
	}
}
