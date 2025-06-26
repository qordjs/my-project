package com.example.backend.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.Map;

@Getter
@Setter
@Entity
@Table(name = "blog_posts")
public class BlogPost {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "blog_posts_id_gen")
    @SequenceGenerator(name = "blog_posts_id_gen", sequenceName = "blog_posts_id_seq", allocationSize = 1)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Size(max = 200)
    @NotNull
    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "content", length = Integer.MAX_VALUE)
    private String content;

    @Size(max = 255)
    @Column(name = "thumbnail_image")
    private String thumbnailImage;

    @ColumnDefault("CURRENT_TIMESTAMP")
    @Column(name = "published_date")
    private Instant publishedDate;

    @Column(name = "tags")
    @JdbcTypeCode(SqlTypes.JSON)
    private Map<String, Object> tags;

    @ColumnDefault("CURRENT_TIMESTAMP")
    @Column(name = "created_at")
    private Instant createdAt;

    @ColumnDefault("CURRENT_TIMESTAMP")
    @Column(name = "updated_at")
    private Instant updatedAt;

}