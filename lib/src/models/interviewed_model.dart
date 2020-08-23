import 'dart:convert';

Interviewed interviewedFromMap(String str) => Interviewed.fromMap(json.decode(str));

String interviewedToMap(Interviewed data) => json.encode(data.toMap());

class Interviewed {
    Interviewed({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.englishLevel,
        this.linkedinUrl,
        this.country,
        this.company,
        this.phone,
        this.skills,
        this.status,
        this.area,
        this.rrhhInterviewer,
        this.rrhhFeedback,
        this.rejectReason,
        this.technicalInterviewer,
        this.technicalFeedback,
        this.levelRecommendation,
    });

    int id;
    String firstName;
    String lastName;
    String email;
    String englishLevel;
    String linkedinUrl;
    String country;
    String company;
    String phone;
    String skills;
    String status;
    String area;
    String rrhhInterviewer;
    String rrhhFeedback;
    String rejectReason;
    String technicalInterviewer;
    String technicalFeedback;
    String levelRecommendation;

    factory Interviewed.fromMap(Map<String, dynamic> json) => Interviewed(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        englishLevel: json["english_level"],
        linkedinUrl: json["linkedin_url"],
        country: json["country"],
        company: json["company"],
        phone: json["phone"],
        area: json["area"],
        status: json["status"],
        skills: json["skills"],
        rrhhInterviewer: json["rrhh_interviewer"],
        rrhhFeedback: json["rrhh_feedback"],
        rejectReason: json["reject_reason"],
        technicalInterviewer: json["technical_interviewer"],
        technicalFeedback: json["technical_feedback"],
        levelRecommendation: json["level_recommendation"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "english_level": englishLevel,
        "linkedin_url": linkedinUrl,
        "country": country,
        "company": company,
        "area": area,
        "phone": phone,
        "skills": skills,
        "status": status,
        "rrhh_interviewer": rrhhInterviewer,
        "rrhh_feedback": rrhhFeedback,
        "reject_reason": rejectReason,
        "technical_interviewer": technicalInterviewer,
        "technical_feedback": technicalFeedback,
        "level_recommendation": levelRecommendation,
    };
}