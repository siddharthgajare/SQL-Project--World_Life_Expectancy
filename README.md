# World Life Expectancy Analysis

## Project Overview

This project is centered around analyzing global life expectancy trends using a comprehensive dataset. The dataset contains valuable information such as life expectancy, GDP, BMI, and country status (Developed/Developing) across various countries and years. The primary objective was to uncover insights into how these factors correlate with life expectancy, offering a visual representation of these trends for enhanced understanding.

## Dataset

The dataset utilized in this analysis includes crucial data points:

- Country
- Year
- Life Expectancy
- GDP
- BMI
- Status (Developed/Developing)

The data was sourced from DataHub, providing a robust foundation for comprehensive analysis.

## Data Cleaning

The dataset underwent meticulous cleaning to ensure accuracy and reliability:

- Removal of duplicate entries based on country and year to maintain data integrity.
- Correction of missing values in the 'Status' column through comparison with neighboring years' data.
- Filling in missing 'Life Expectancy' values by averaging data from adjacent years.
- Thorough validation checks were conducted to ensure consistency and accuracy of the dataset.

## Data Exploration

Key exploration points included:

- Calculating the difference in life expectancy over 15 years for each country to discern trends.
- Exploring the average life expectancy of countries over the years to identify patterns.
- Investigating the correlation between average life expectancy and GDP, highlighting trends.
- Comparing life expectancy between countries with high and low GDP to draw insightful comparisons.
- Analyzing the average life expectancy based on country status (Developed/Developing) to understand disparities.
- Exploring the correlation between life expectancy and BMI, revealing intriguing insights.
- Detailed examination of the impact of adult mortality on life expectancy trends through rolling total calculations.

## Results

The analysis yielded significant findings:

- Countries with higher GDP generally exhibit higher average life expectancies, indicating a positive correlation.
- Developed countries tend to have higher life expectancies compared to developing countries, reflecting disparities.
- Lower BMI is associated with higher average life expectancy, an insightful observation from the data.
- The impact of adult mortality on life expectancy trends was analyzed, providing valuable insights into the factors affecting life expectancy.

This project not only offers insights into global life expectancy trends but also showcases the power of data analysis in uncovering meaningful patterns and correlations.

You can explore the detailed analysis and visualizations in the Jupyter Notebook within this repository.
