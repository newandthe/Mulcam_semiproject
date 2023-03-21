package a.dao.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import a.dto.FreePostDto;
import a.dto.MemberDto;
import a.dto.BbsImgVO;
import a.dto.BbsParam;
import a.dto.FpdImgDto;
import a.dto.FreeCommentVO;

@Repository
public class FreePostDaoImpl {
	
    @Autowired
    SqlSession sqlSession;
    
    String ns = "FreeBbs.";
    
    public List<FreePostDto> bbslist(BbsParam param) {
        return sqlSession.selectList(ns + "bbslist", param);
    }

    public int getAllBbs(BbsParam param) {
        return sqlSession.selectOne(ns + "getAllBbs", param);
    }
    
    
     
     
    // 글 작성 (사진이 없다면)
    public int writeBbs(FreePostDto dto) {
		return sqlSession.insert(ns + "writeBbs", dto);
	}
    
    // 글 작성 (사진이 있다면)
	public int writeBbs(FreePostDto dto, List<BbsImgVO> bbsImglist) {
		sqlSession.insert(ns + "writeBbs", dto);
		System.out.println(dto.toString());
		
		// 글 내용 DB에 추가
		int n=0;
		
		for (BbsImgVO bbsImg : bbsImglist) {
			// 각각의 모든 img를 콘트롤러에서 set된 dto for문 돌면서 모두 추가.
			System.out.println("multiimg + img_rel : " + (n+1));
			sqlSession.insert(ns + "multiimg", bbsImg);
			sqlSession.insert(ns + "img_rel2");
			
			n++;
		}
		
		return n;
	}
    
    
    // 게시물 상세보기
    
    public FpdImgDto getBbs(int bbs_seq) {

    	//게시물 영역
    	sqlSession.update(ns + "increaseReadcount", bbs_seq);
    	FpdImgDto dto = new FpdImgDto();
    	
    	FreePostDto fdto = sqlSession.selectOne(ns + "getBbs", bbs_seq);
    	List<BbsImgVO> ivo = sqlSession.selectList(ns + "getImg", bbs_seq);
    	
    	// 댓글 관련 sqlSession 추가. + FpdImgDto에 commentDto추가
    	List<FreeCommentVO> cvo = sqlSession.selectList(ns + "getComment", bbs_seq);

    	dto.setFreepostdto(fdto);
    	dto.setBbsimgvo(ivo);
    	dto.setCommentvo(cvo);
    	
    	
    	// 아래는 댓글영역
    	// 게시물 작성자
    	MemberDto writorbbs = sqlSession.selectOne(ns + "getWitor", bbs_seq);
    	// 댓글 작성자들
    	List<MemberDto> cmtwriotrs = sqlSession.selectList(ns + "getCmtWritors", bbs_seq);
    	
    	
    	dto.setWritor(writorbbs);
    	dto.setCmtwritorlist(cmtwriotrs);
    	

    	return dto;
    }

    // 게시글 수정 (사진이 없는 경우)
	public int updateBbs(FreePostDto dto, int bbs_seq) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("bbs_seq", bbs_seq);
	    paramMap.put("dto", dto);
	    
		sqlSession.update(ns + "updateBbs", paramMap);
		return 0;
	}
    
    // 게시글 수정 (사진이 있는 경우)
	public int updateBbs(FreePostDto dto, List<BbsImgVO> bbsImglist, int bbs_seq) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("bbs_seq", bbs_seq);
	    paramMap.put("dto", dto);
	    
		sqlSession.update(ns + "updateBbs", paramMap);
		// 글 내용 DB 수정
		
		
		// 수정의 경우 기존의 이미지 DB 테이블의 컬럼을 모두 지우고 새로 들어온 이미지들을 추가해야한다.. 
		// (경로에 이미지 자체를 삭제하기 때문에 남겨두는게 의미가 없음.) 
		// + detail에서 불러올때 삭제하지않으면 404에러 발생.
		// 이를 해결하기 위해선 DB에 del 컬럼도 하나더 추가해야합니다.
		sqlSession.delete(ns + "deleteimg_rel", bbs_seq);
		sqlSession.delete(ns + "deleteMultiImg", bbs_seq);
		
		int n=0;
		// 이미지 내용 DB에 삭제후 수정
		for (BbsImgVO bbsImg : bbsImglist) {
			// 각각의 모든 img를 콘트롤러에서 set된 dto for문 돌면서 모두 추가.
			System.out.println("multiimg + img_rel 삭제중.. : " + (n+1));
			
			sqlSession.insert(ns + "multiimg", bbsImg);
			sqlSession.insert(ns + "img_rel", bbs_seq);
			
			n++;
		}
		
		return n;
		
	}
    
    // 게시물 삭제 ( FreePost의 del컬럼 1로 update set, 실제 경로 이미지 삭제됩니다.)
    public boolean deleteFreePost(int bbs_seq) {
        int n = sqlSession.delete(ns + "deleteFreePost", bbs_seq);
        
        List<BbsImgVO> ivo = sqlSession.selectList(ns + "getImg", bbs_seq);
        
        
        // DB테이블에 이미지 경로와 path는 남아있지만, 저희 작품에 복구 기능도 없고 실제 이미지를 일단 이대로 삭제진행해보겠습니다..
        // 넘어온 리스트가 있는경우 파일 경로와 이름을 조회해서 모두 삭제.
        if (ivo != null) {
            for (BbsImgVO img : ivo) {
                String filePath = img.getImg_path() + "/" + img.getImg_name();
                File file = new File(filePath);
                if (file.exists()) {
                    try {
                        if (file.delete()) {
                            // 파일 삭제 성공
                            System.out.println("파일 삭제 성공: " + img.getImg_path() + "/" + img.getImg_name());
                            n++;
                        } else {
                            // 파일 삭제 실패
                            System.out.println("파일 삭제 실패: 경로나 해당 파일의 위치에 없으면.");
                        }
                    } catch (SecurityException e) {
                        // 파일 삭제 권한이 없는 경우
                        System.out.println("파일 삭제 실패: 삭제 권한이 없음.");
                        e.printStackTrace();
                    }
                } else {
                    // 파일이 존재하지 않음
                    System.out.println("파일 삭제 실패: 경로나 해당 파일의 위치에 없으면.");
                }
            }
        }
        
        
        return n>0?true:false;
    }
    
    // 게시물 이미지 가져오기
    public String getFreePostImage(int bbs_seq) {
        String freePostImage = null;
        freePostImage = sqlSession.selectOne("freePost.getFreePostImage", bbs_seq);
        return freePostImage;
    }
    
    public String getFreePostFirstImage(int postId) {
        String firstImage = sqlSession.selectOne("freePost.getFreePostFirstImage", postId);
        return firstImage;
    }

    public List<FreePostDto> getMainBbs(){
    	List<FreePostDto> list = sqlSession.selectList("FreeBbs.getMainBbs");
    	return list;
    }

    










    
}


