package kr.or.ddit.company.service;

import kr.or.ddit.company.dao.WaitingListDAO;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.dao.AssociationDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
@Slf4j
public class WaitingListServiceImpl implements WaitingListService{

    private final WaitingListDAO waitingListDAO;
    private final AssociationDAO associationDAO;
    @Override
    public int waitingListInsert(CompanyVO company) {
        return waitingListDAO.waitingListInsert(company);
    }

    @Override
    public int updateMemberStatus(CompanyVO companyVO) {
        return waitingListDAO.updateMemberStatus(companyVO);
    }

    @Override
    public int updateMemberRefuse(CompanyVO company) {
        int i = associationDAO.deleteAssociation(company);
        log.info("삭제됐니 = {}",i);
        return waitingListDAO.updateMemberRefuse(company);
    }

    @Override
    public int waitingListDelete(CompanyVO company) {
        return waitingListDAO.waitingListDelete(company);
    }
}
