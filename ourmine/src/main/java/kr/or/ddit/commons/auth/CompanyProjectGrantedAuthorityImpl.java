package kr.or.ddit.commons.auth;

import org.springframework.security.core.GrantedAuthority;

public class CompanyProjectGrantedAuthorityImpl implements GrantedAuthority{
	
	private int companyID;
	private int projectID;
	
	
	
	
	public CompanyProjectGrantedAuthorityImpl(int companyID, int projectID) {
		super();
		this.companyID = companyID;
		this.projectID = projectID;
		
	}

	


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + companyID;
		result = prime * result + projectID;
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
		CompanyProjectGrantedAuthorityImpl other = (CompanyProjectGrantedAuthorityImpl) obj;
		if (companyID != other.companyID)
			return false;
		if (projectID != other.projectID)
			return false;
		return true;
	}




	@Override
	public String getAuthority() {
		
		return String.format("%d_%d", companyID, projectID);
	}
	
	
	@Override
	public String toString() {
	
		return getAuthority();
	}

	
	
}
