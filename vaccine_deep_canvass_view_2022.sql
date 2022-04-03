SELECT DISTINCT * FROM (SELECT DISTINCT
    pracc.tmc_id
    ,CAST(pracc.contactscontactid as VARCHAR) as contact_id
    ,CAST(pracc.datecanvassed as date) as date
    ,CAST(pracc.canvassedby as VARCHAR) as canvasser_id
    ,(case
        when canvasser_id = 2195597 then 'Eric Morgan'
        when canvasser_id = 2068362 then 'Maria Perez'
        when canvasser_id = 2190882 then 'Gabe Casanave-Cohen'
        when canvasser_id = 2195660 then 'Trysten McClaine'
        when canvasser_id = 1978788 then 'Katy Allen'
        when canvasser_id = 2190883 then 'Leo Stewart'
        when canvasser_id = 130228826 then 'Dögg Hugosdóttir'
        when canvasser_id = 2068373 then 'Dögg Hugosdóttir' END) AS canvassed_by
    ,CAST(parasrs.contacttypename as VARCHAR) as contact_type
    ,'MyVoters' as contact_source
    ,social_needs
    ,wellness_rating
    ,five_year_scale
    ,vax_status
    ,first_rating
    ,no_vax_reasoning
    ,final_rating
    ,scheduled_vax
    ,is_pharma_expensive
    ,issue_campaign
    ,text_opt_in
    ,dud
    ,rad_alignment

    ,van_gender
    ,van_race
    ,van_township
    ,van_ward
FROM tmc_av_van.pa_rad_av_contacts_contacts pracc
left join tmc_av_van.pa_rad_av_survey_responses_summary parasrs
    on pracc.tmc_id = parasrs.tmc_id
left join (SELECT
    tmc_id as tmc_id1
    ,surveyresponsename as social_needs
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX: social needs')
    on parasrs.tmc_id = tmc_id1
--survey question2 VAX: WellnessRating
left join (SELECT
    tmc_id as tmc_id2
    ,surveyresponsename as wellness_rating
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX: WellnessRating')
    on parasrs.tmc_id = tmc_id2
--survey question3 VAX: 5yrsScale
left join (SELECT
    tmc_id as tmc_id3
    ,surveyresponsename as five_year_scale
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX:5yrsScale')
    on parasrs.tmc_id = tmc_id3
--survey question4 VAX: GottenVax
left join (SELECT
    tmc_id as tmc_id4
    ,surveyresponsename as vax_status
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX:GottenVax')
    on parasrs.tmc_id = tmc_id4
--survey question5 VAX: First rating
left join (SELECT
    tmc_id as tmc_id5
    ,surveyresponsename as first_rating
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX: First rating')
    on parasrs.tmc_id = tmc_id5
--survey question6 VAX: If No why
left join (SELECT
    tmc_id as tmc_id6
    ,surveyresponsename as no_vax_reasoning
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX: If No why')
    on parasrs.tmc_id = tmc_id6
--survey question7 VAX: Final rating
left join (SELECT
    tmc_id as tmc_id7
    ,surveyresponsename as final_rating
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX: Final rating')
    on parasrs.tmc_id = tmc_id7
--survey question8 VAX: Scheduled Vax
left join (SELECT
    tmc_id as tmc_id8
    ,surveyresponsename as scheduled_vax
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'VAX: sched vax')
    on parasrs.tmc_id = tmc_id8
--survey question 8.5 Pharma Pay too much
left join (SELECT
    tmc_id as tmc_id85
    ,surveyresponsename as is_pharma_expensive
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'Pharma pay too much')
    on parasrs.tmc_id = tmc_id85
--survey question9 Issue Campaign 21
left join (SELECT
    tmc_id as tmc_id9
    ,surveyresponsename as issue_campaign
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'Issue Campaign 21')
    on parasrs.tmc_id = tmc_id9
--survey question10 Text Opt In
left join (SELECT
    tmc_id as tmc_id10
    ,surveyresponsename as text_opt_in
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'Text Opt In')
    on parasrs.tmc_id = tmc_id10
--survey question11 Dud
left join (SELECT
    tmc_id as tmc_id11
    ,surveyresponsename as dud
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'Dud')
    on parasrs.tmc_id = tmc_id11
--survey question12 RAD Alignment
left join (SELECT
    tmc_id as tmc_id12
    ,surveyresponsename as rad_alignment
    from tmc_av_van.pa_rad_av_survey_responses_summary
    WHERE campaignid = 34136 and surveyquestionname = 'RAD Alignment')
    on parasrs.tmc_id = tmc_id12
--demographics from pa_rad_van.contacts
left join (SELECT
    tmcid
    ,age as van_age
    ,gender as van_gender
    ,race as van_race
    ,township as van_township
    ,ward as van_ward
    from pa_rad_van.contacts) on tmcid = parasrs.tmc_id
WHERE pracc.campaignid = 34136) LEFT JOIN (SELECT resultshortname FROM tmc_av_van.pa_rad_av_contact_attempts_summary pracas) ON tmc_av_van.pa_rad_av_contacts_contacts.tmc_id = tmc_av_van.pa_rad_av_contact_attempts_summary.tmc_id
