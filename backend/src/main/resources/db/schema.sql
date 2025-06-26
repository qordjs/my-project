--USER
CREATE TABLE users (
                       id SERIAL PRIMARY KEY, -- 자동 증가하는 고유 식별자
                       name VARCHAR(100) NOT NULL, -- 이름 (필수값, 최대 100자)
                       email VARCHAR(100) UNIQUE, -- 이메일 주소 (중복 불가)
                       introduction TEXT, -- 자기소개 (텍스트 길이 제한 없음)
                       profile_image VARCHAR(255), -- 프로필 이미지 경로/URL (최대 255자)
                       social_links JSONB, -- 소셜 미디어 링크 (예: {"github": "url", "linkedin": "url"})
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 레코드 생성 시간 (자동 기록)
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 레코드 수정 시간 (자동 기록)
);

-- 업데이트 트리거 생성 (updated_at 자동 갱신)
CREATE OR REPLACE FUNCTION update_modified_column()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_modtime
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

--PROJECT

CREATE TABLE projects (
                          id SERIAL PRIMARY KEY, -- 자동 증가하는 고유 식별자
                          title VARCHAR(200) NOT NULL, -- 프로젝트 제목 (필수값, 최대 200자)
                          description TEXT, -- 간략한 프로젝트 설명 (텍스트 길이 제한 없음)
                          thumbnail_image VARCHAR(255), -- 썸네일 이미지 경로/URL (최대 255자)
                          detail_content TEXT, -- 상세 프로젝트 내용 (마크다운/HTML 지원)
                          github_link VARCHAR(255), -- GitHub 저장소 링크 (최대 255자)
                          demo_link VARCHAR(255), -- 데모 사이트 링크 (최대 255자)
                          start_date DATE, -- 프로젝트 시작일 (YYYY-MM-DD 형식)
                          end_date DATE, -- 프로젝트 종료일 (NULL이면 진행 중)
                          featured BOOLEAN DEFAULT FALSE, -- 주요 프로젝트 여부 (메인에 표시할지)
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 레코드 생성 시간 (자동 기록)
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 레코드 수정 시간 (자동 기록)
);

-- 업데이트 트리거 생성
CREATE TRIGGER update_projects_modtime
    BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

--SKILLS

CREATE TABLE skills (
                        id SERIAL PRIMARY KEY, -- 자동 증가하는 고유 식별자
                        name VARCHAR(100) NOT NULL, -- 기술 이름 (필수값, 최대 100자)
                        category VARCHAR(50), -- 기술 분류 (frontend, backend, devops 등)
                        proficiency_level INTEGER CHECK (proficiency_level BETWEEN 1 AND 5), -- 숙련도 (1-5)
                        logo_image VARCHAR(255), -- 기술 로고 이미지 경로/URL (최대 255자)
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 레코드 생성 시간 (자동 기록)
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 레코드 수정 시간 (자동 기록)
);

-- CHECK 제약조건: proficiency_level은 1에서 5 사이의 값만 허용
-- 업데이트 트리거 생성
CREATE TRIGGER update_skills_modtime
    BEFORE UPDATE ON skills
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();


--PROJECT_SKILLS
-- 다대다 관계: 하나의 프로젝트는 여러 기술 사용 가능, 하나의 기술은 여러 프로젝트에 사용 가능
-- REFERENCES: 외래 키로 다른 테이블 참조
-- ON DELETE CASCADE: 참조하는 레코드 삭제 시 연결된 데이터도 자동 삭제
CREATE TABLE project_skills (
                                project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE, -- 프로젝트 참조 (프로젝트 삭제 시 함께 삭제)
                                skill_id INTEGER REFERENCES skills(id) ON DELETE CASCADE, -- 기술 참조 (기술 삭제 시 함께 삭제)
                                PRIMARY KEY (project_id, skill_id) -- 복합 기본키 (중복 방지)
);

--EXPERIENCES
CREATE TABLE experiences (
                             id SERIAL PRIMARY KEY, -- 자동 증가하는 고유 식별자
                             company_name VARCHAR(100) NOT NULL, -- 회사명 (필수값, 최대 100자)
                             position VARCHAR(100) NOT NULL, -- 직책/직무 (필수값, 최대 100자)
                             description TEXT, -- 업무 설명 (텍스트 길이 제한 없음)
                             start_date DATE NOT NULL, -- 시작일 (필수값, YYYY-MM-DD 형식)
                             end_date DATE, -- 종료일 (NULL은 현재 재직 중)
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 레코드 생성 시간 (자동 기록)
                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 레코드 수정 시간 (자동 기록)
);

-- 업데이트 트리거 생성
CREATE TRIGGER update_experiences_modtime
    BEFORE UPDATE ON experiences
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

--BLOG

CREATE TABLE blog_posts (
                            id SERIAL PRIMARY KEY, -- 자동 증가하는 고유 식별자
                            title VARCHAR(200) NOT NULL, -- 포스트 제목 (필수값, 최대 200자)
                            content TEXT, -- 포스트 내용 (마크다운/HTML 지원)
                            thumbnail_image VARCHAR(255), -- 썸네일 이미지 경로/URL (최대 255자)
                            published_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 게시일 (기본값: 현재 시간)
                            tags JSONB, -- 태그 배열 (예: ["React", "NextJS", "Spring"])
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 레코드 생성 시간 (자동 기록)
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 레코드 수정 시간 (자동 기록)
);

-- JSONB: 바이너리 JSON 형식으로 저장하여 쿼리 성능 향상
-- 업데이트 트리거 생성
CREATE TRIGGER update_blog_posts_modtime
    BEFORE UPDATE ON blog_posts
    FOR EACH ROW EXECUTE FUNCTION update_modified_column();

