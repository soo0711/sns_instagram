package com.sns.post.entity;

import java.time.ZonedDateTime;

import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "post")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PostEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "userId")
	private int userId;
	
	private String content;
	
	@Column(name ="imagePath")
	private String imagePath;
	
	@UpdateTimestamp
	@Column(name ="createdAt", updatable = false)
	private ZonedDateTime createdAt;
	
	@UpdateTimestamp
	@Column(name ="updatedAt")
	private ZonedDateTime updatedAt;
}
