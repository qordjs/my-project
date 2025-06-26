package com.example.backend.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.util.Objects;

@Getter
@Setter
@Embeddable
public class ProjectSkillId implements java.io.Serializable {
    private static final long serialVersionUID = 2106673969080999113L;
    @NotNull
    @Column(name = "project_id", nullable = false)
    private Integer projectId;

    @NotNull
    @Column(name = "skill_id", nullable = false)
    private Integer skillId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ProjectSkillId entity = (ProjectSkillId) o;
        return Objects.equals(this.skillId, entity.skillId) &&
                Objects.equals(this.projectId, entity.projectId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(skillId, projectId);
    }

}