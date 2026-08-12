package com.ait.web.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ait.sys.service.SendEmailSer;

/**
 *  发送审批邮件
 */
@Component
public class SendEmailTask {
	
	@Autowired
	private SendEmailSer sendEmailSer;

	
	/**
	 * 是否验证
	 * 	1：发送
	 *  0：不发送
	 */
    @Value("${mail.send.flag}")
	private String MAIL_SEND_FLAG;
  //<!-- 2018/07 Start EagleOffice 连接HR System -->
    /**
	 * 审批信息发送标识
	 * 	1：发送
	 *  0：不发送
	 */
    //@Value("${approval.send.flag}")
	private String APPROVAL_SEND_FLAG = "0";
	//<!-- 2018/07 End EagleOffice 连接HR System -->
	/**
	 *   发送审批邮件SST
	 */
	//@Scheduled(cron = "0 0/1 * * * ?")
	public void SendAffirmEmailTask() {
		if("0".equals(MAIL_SEND_FLAG)){
			//SST发送审批邮件
			//sendEmailSer.sendAffirmEmail();
		}
	}
    
	/**
	 *   发送评价邮件
	 */
	//@Scheduled(cron = "0 0/1 * * * ?")
	public void SendEvsEmailTask() {
		if("0".equals(MAIL_SEND_FLAG)){
			//SST发送审批邮件
			//sendEmailSer.sendEvsEmail();
		}
	}
	
	/**
	 *   发送审批邮件HTSV(一次决裁人15:30) 
	 */
	//@Scheduled(cron = "0 30 15 * * ?")
	public void SendAffirmEmailHTSV1Task() {
		if("1".equals(MAIL_SEND_FLAG)){
			//SST发送审批邮件
			sendEmailSer.sendAffirmEmailHAE(1);  //<!-- 2018/07 Start EagleOffice 连接HR System -->
		}
	}
	
	/**
	 *   发送审批邮件HTSV(二次决裁人15:50) 
	 */
	//@Scheduled(cron = "0 50 15 * * ?")
	public void SendAffirmEmailHTSV2Task() {
		if("1".equals(MAIL_SEND_FLAG)){
			//SST发送审批邮件
			sendEmailSer.sendAffirmEmailHAE(2);  //<!-- 2018/07 Start EagleOffice 连接HR System -->
		}
	}
	
	/**
	 *   发送审批邮件HTSV(三次决裁人16:10) 
	 */
	//@Scheduled(cron = "0 10 16 * * ?")
	public void SendAffirmEmailHTSV3Task() {
		if("1".equals(MAIL_SEND_FLAG)){
			//SST发送审批邮件
			sendEmailSer.sendAffirmEmailHAE(3);  //<!-- 2018/07 Start EagleOffice 连接HR System -->
		}
	}
	
	/**
	 *   发送审批邮件HTSV(三次决裁人16:10)(test)
	 */
	public void SendAffirmEmailHTSVTestTask() {
		//SST发送审批邮件
		//sendEmailSer.sendAffirmEmailTSTO(1);
		//sendEmailSer.sendAffirmEmailTSTO(2);
		//sendEmailSer.sendAffirmEmailTSTO(3);
	}
	//<!-- 2018/07 Start EagleOffice 连接HR System -->
	/**
	 *   定时同步eagleoffice中审批信息的状态
	 */
	@Scheduled(cron = "0 0/5 * * * ?")
	public void SynchronizationApprovalStatus() {
		if("1".equals(APPROVAL_SEND_FLAG)){
			//HAE同步审批信息
			sendEmailSer.synchronizationApprovalStatus();
		}
	}
	//<!-- 2018/07 End EagleOffice 连接HR System -->
}
