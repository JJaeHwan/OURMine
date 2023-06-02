package kr.or.ddit.commons.auth;

import org.springframework.security.core.GrantedAuthority;

import lombok.Getter;

@Getter
public class CustomGrantedAuthorityImpl implements GrantedAuthority{
	
	private int companyID;
	private int projectID;
	private String role;
	private int memberId;
	private int projectRoleId;
	private int projectAttendAk;
	


	@Override
	public String getAuthority() {
		
		return String.format("%d_%d_%s", companyID, projectID, role);
	}
	
	
	@Override
	public String toString() {
	
		return getAuthority();
	}




	public CustomGrantedAuthorityImpl(int companyID, int projectID, String role, int memberId, int projectRoleId,
			int projectAttendAk) {
		super();
		this.companyID = companyID;
		this.projectID = projectID;
		this.role = role;
		this.memberId = memberId;
		this.projectRoleId = projectRoleId;
		this.projectAttendAk = projectAttendAk;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + companyID;
		result = prime * result + memberId;
		result = prime * result + projectAttendAk;
		result = prime * result + projectID;
		result = prime * result + projectRoleId;
		result = prime * result + ((role == null) ? 0 : role.hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CustomGrantedAuthorityImpl other = (CustomGrantedAuthorityImpl) obj;
		if (companyID != other.companyID)
			return false;
		if (memberId != other.memberId)
			return false;
		if (projectAttendAk != other.projectAttendAk)
			return false;
		if (projectID != other.projectID)
			return false;
		if (projectRoleId != other.projectRoleId)
			return false;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		return true;
	}

	
	
	
	
}
