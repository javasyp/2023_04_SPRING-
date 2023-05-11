package com.KoreaIT.syp.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.KoreaIT.syp.demo.vo.Member;

@Mapper
public interface MemberRepository {
	
	@Insert("""
			INSERT INTO `member`
			SET regDate = NOW(),
			updateDate = NOW(),
			loginId = #{loginId},
			loginPw = #{loginPw},
			`name` = #{name},
			nickname = #{nickname},
			cellphoneNum = #{cellphoneNum},
			email = #{email}
			""")
	void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);
	
	@Select("""
			SELECT *
			FROM `member`
			WHERE id = #{id}
			""")
	Member getMemberById(int id);
	
	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();
	
	// 아이디 중복 체크
	@Select("""
			SELECT *
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	Member getMemberByLoginId(String loginId);
	
	// 이름 + 이메일 중복 체크
	@Select("""
			SELECT *
			FROM `member`
			WHERE name = #{name}
			AND email = #{email}
			""")
	Member getMemberByNameAndEmail(String name, String email);
	
	// 회원 정보 수정
	@Update("""
			<script>
				UPDATE `member`
				<set>
					<if test="loginPw != null">
						loginPw = #{loginPw},
					</if>
					<if test="name != null">
						name = #{name},
					</if>
					<if test="nickname != null">
						nickname = #{nickname},
					</if>
					<if test="cellphoneNum != null">
						cellphoneNum = #{cellphoneNum},
					</if>
					<if test="email != null">
						email = #{email},
					</if>
					updateDate = NOW()
				</set>
				WHERE id = #{id}
			</script>
			""")
	void modify(int id, String loginPw, String name, String nickname, String cellphoneNum, String email);

	@Select("""
			<script>
				SELECT COUNT(*) AS cnt
				FROM `member` AS M
				WHERE 1
				<if test="authLevel != 0">
					AND M.authLevel = #{authLevel}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchType == 'loginId'">
							AND M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchType == 'name'">
							AND M.name LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchType == 'nickname'">
							AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND (
								M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
								OR M.name LIKE CONCAT('%', #{searchKeyword}, '%')
								OR M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
								)
						</otherwise>
					</choose>
				</if>
			</script>
			""")
	int getMembersCount(String authLevel, String searchType, String searchKeyword);

	@Select("""
			<script>
				SELECT M.*
				FROM `member` AS M
				WHERE 1
				<if test="authLevel != 0">
					AND M.authLevel = #{authLevel}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchType == 'loginId'">
							AND M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchType == 'name'">
							AND M.name LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchType == 'nickname'">
							AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND (
								M.loginId LIKE CONCAT('%', #{searchKeyword}, '%')
								OR M.name LIKE CONCAT('%', #{searchKeyword}, '%')
								OR M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
								)
						</otherwise>
					</choose>
				</if>
				ORDER BY M.id DESC
					<if test="limitTake != -1">
						LIMIT #{limitStart}, #{limitTake}
					</if>
			</script>
			""")
	List<Member> getForPrintMembers(String authLevel, String searchType, String searchKeyword,
			int limitStart, int limitTake);

	
}
