package kr.or.ddit.commons.auth;

import org.springframework.security.core.GrantedAuthority;

public class CompanyGrantedAuthorityImpl implements GrantedAuthority{
	
	private int companyID;

	
	
	
	
	public CompanyGrantedAuthorityImpl(int companyID) {
		super();
		this.companyID = companyID;
	
	}

	
	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + companyID;
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
		CompanyGrantedAuthorityImpl other = (CompanyGrantedAuthorityImpl) obj;
		if (companyID != other.companyID)
			return false;
		return true;
	}




	@Override
	public String getAuthority() {
		
		return String.format("%d", companyID);
	}
	
	
	@Override
	public String toString() {
	
		return getAuthority();
	}

	
	
}
