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
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Size(min = 2, message = "First name must be at least 2 characters long.")
	private String fname;
	@Size(min = 2, message = "Last name must be at least 2 characters long.")
	private String lname;
	@Email(message="Email must be a valid email format.")
	private String email;
	@NotNull(message="City cannot be empty.")
	private String city;
	@NotNull(message="State cannot be empty.")
	private String state;
	@Size(min = 6, message="Password must be at least 6 characters long.")
	private String password;
	@Transient
	private String passConf;
	@Column(updatable=false)
	private Date createdAt;
	private Date updatedAt;
	@OneToMany(mappedBy="uploader", fetch = FetchType.LAZY)
	private List<Event> events;
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		name="rsvps",
		joinColumns = @JoinColumn(name="user_id"),
		inverseJoinColumns = @JoinColumn(name="event_id")
	)
	private List<Event> rsvps;
	@OneToMany(mappedBy="messager", fetch = FetchType.LAZY)
	private List<Message> messages;
	
	public User() {
		
	}
	
	public User(String fname, String lname, String email, String city, String state, String password) {
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.city = city;
		this.state = state;
		this.password = password;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassConf() {
		return passConf;
	}

	public void setPassConf(String passConf) {
		this.passConf = passConf;
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

	public List<Event> getEvents() {
		return events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}
	
	public void addEvent(Event event) {
		this.events.add(event);
	}

	public List<Event> getRsvps() {
		return rsvps;
	}

	public void setRsvps(List<Event> rsvps) {
		this.rsvps = rsvps;
	}
	
	public void addRsvp(Event event) {
		this.rsvps.add(event);
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
