package a.dao;

import java.util.List;

import a.dto.FreePostDto;
import a.dto.BbsParam;

public interface FreePostDao {
	List<FreePostDto> bbslist(BbsParam param);
	
	int getAllBbs(BbsParam param);
	
	int writeBbs(FreePostDto dto);
	
	FreePostDto getBbs(int seq);
	
	List<FreePostDto> getMainBbs();
}
