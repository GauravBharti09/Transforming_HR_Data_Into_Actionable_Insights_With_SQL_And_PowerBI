# Transforming_HR_Data_Into_Actionable_Insights_With_SQL_And_PowerBI

![Workforce Analytics Dashboard](https://github.com/GauravBharti09/Transforming_HR_Data_Into_Actionable_Insights_With_SQL_And_PowerBI/blob/main/HR%20Analytics%20Dashboard.jpg)

### Description
This project focuses on creating a comprehensive workforce analytics dashboard using MySQL for data processing and Power BI for visualization. The aim is to analyze key workforce metrics such as gender distribution, race diversity, employee turnover, and age distribution, offering insights into the workforce composition and trends.

### Objective:
The objective of this project was to gain actionable insights into the workforce's composition and behavior. 
Key business challenges included:
* Understanding the gender, race, and age distribution across various departments.
* Identifying which departments had higher termination/turnover rates.
* Tracking the workforce’s headcount changes over the years and location distribution.
* Assessing employee retention and tenure across departments.

### Tools Used:
* SQL (MySQL): Data Cleaning and Querying
* Power BI: Visualization and Dashboard Creation

### Process:
**1. Data Cleaning And Transformation:**
   * Renamed columns and updated data types for improved readability and consistency (e.g., gender, location).
   * Standardized date formats (birthdate, hire_date, termdate) using date_format and str_to_date functions to ensure proper date handling.
   * Fixed incorrect birthdate values, where some dates exceeded the current year.

**2. New Columns And Calculations:**
   * Added an age column using timestampdiff() to calculate employee ages dynamically.
   * Performed age adjustments for employees with invalid birthdates (dates greater than the current year).

**3. Dashboard Creation:**
* Compiled all visuals into a new worksheet For creating a Dashboard.
* Organized the slicers, timeline, and charts for a clean and cohesive user interface.
* Applied report connections to ensure that the slicers and timeline controlled all visuals simultaneously.

**4. Dashboard Customization:**
* Enhanced the dashboard aesthetics by adjusting colors, fonts, and labels.
* Removed gridlines and utilized Excel's advanced display settings to hide unnecessary elements like scroll bars and headers for a more professional look.

### Key Queries And Insights:
* Gender Breakdown: Query to determine the gender distribution among active employees (WHERE termdate IS NULL).
* Race Breakdown: Segmented race distribution among active employees.
* Age Group Distribution: Created age brackets (0-25, 26-40, 41-60, 60+) to categorize employees.
* Location-Based Distribution: Analyzed how many employees work in headquarters vs. remote locations.
* Employee Turnover: Calculated the average employment length and termination rate for employees who left.
* Departmental Gender Distribution: Examined gender distribution across departments and job titles.
* Headcount & Turnover by Department: Identified departments with the highest termination rates.
* Statewise Distribution: Mapped the number of employees across different states.
* Yearly Headcount Changes: Assessed how hiring and termination trends affected the net workforce change over time.
* Advanced Metrics: Generated tenure distribution for each department using average employment length and termination dates.

### Results:
* The average tenure of employees who left the organization was calculated as 8 years.
* Turnover rates were higher in departments such as Legal and Marketing, requiring closer examination of employee satisfaction.
* The gender distribution analysis highlighted a more balanced split across most departments, with the Engineering department having the highest concentration of male employees.
* The location analysis revealed that 75% of the workforce operates from headquarters, with the rest working remotely.
* The age distribution indicates that the majority of employees are between 41-60 years old, while a small fraction falls into the 60+ age group.

### Visualization (Power BI):

**The Dashboard Visualized Key Metrics Such As:**
* Headcount by Department & Gender: Bar chart breaking down gender distribution within each department.
* Race Distribution: Pie chart showing the diversity across the workforce.
* Age Distribution: A bar graph categorizing employees into age brackets.
* Location Distribution: Pie chart illustrating the number of employees in HQ vs. remote locations.
* Tenure and Termination Rates: KPIs to showcase average tenure and termination rates across departments.
* Statewide Distribution: Map showing employee presence across different U.S. states.

**This detailed project showcases advanced SQL queries, combined with Power BI to build a comprehensive and visually rich dashboard that delivers insights to optimize workforce management.**
