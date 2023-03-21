package a.service;

import java.util.List;

import a.dto.FreePostDto;
import a.dto.BbsParam;

public interface FreePostService {
	
	List<FreePostDto> bbslist(BbsParam bbs);
	
	int getAllBbs(BbsParam bbs);
	
	boolean writeBbs(FreePostDto dto);
	
	FreePostDto getBbs(int seq);
	
	List<FreePostDto> getMainBbs();
	
}
