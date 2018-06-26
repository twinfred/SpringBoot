package com.timwinfred.upcomingevents.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.timwinfred.upcomingevents.models.Event;

public interface EventRepository extends CrudRepository<Event, Long> {
	List<Event> findAll();
	
	@Query("SELECT e.name, e.date, e.city, u.fname, u.id, e.id FROM Event e JOIN e.uploader u WHERE e.state = ?1 ORDER BY e.date")
	List<Object[]> findAllEventsInUserState(String state);
	
	@Query("SELECT e.name, e.date, e.city, e.state, u.fname, u.id, e.id FROM Event e JOIN e.uploader u WHERE e.state != ?1 ORDER BY e.date")
	List<Object[]> findAllEventsNotInUserState(String state);
	
	@Query(value="SELECT event_id FROM `upcoming-events`.rsvps WHERE user_id = ?1", nativeQuery=true)
	List<Object[]> findUserRsvps(Long id);
}
