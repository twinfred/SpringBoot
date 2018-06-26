package com.timwinfred.upcomingevents.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name="events")
public class Event {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	@Size(min = 5, message = "Event name must be at least 5 characters long.")
	private String name;
	@NotNull(message="City cannot be empty.")
	private String city;
	@NotNull(message="State cannot be empty.")
	private String state;
	@Future
	private Date date;
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User uploader;
	@OneToMany(mappedBy="event", fetch = FetchType.LAZY)
	private List<Message> messages;
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name="rsvps",
		joinColumns = @JoinColumn(name="event_id"),
		inverseJoinColumns = @JoinColumn(name="user_id")
	)
	private List<User> rsvps;
	
	public Event() {
		
	}

	public Event(String name, String city, String state, Date date, User uploader) {
		this.name = name;
		this.city = city;
		this.state = state;
		this.date = date;
		this.uploader = uploader;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getUploader() {
		return uploader;
	}

	public void setUploader(User uploader) {
		this.uploader = uploader;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	
	public void addMessage(Message message) {
		this.messages.add(message);
	}

	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
	
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}
