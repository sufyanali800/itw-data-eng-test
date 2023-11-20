
    Earthquakes ELT Pipeline

        I would like to go ELT pipeline and Lakehouse architecture

    Step 1: On Board data into lakehouse from all availabel sources
            
            For CSV files: Azure Data Factory 
            to simulate the process, I placed all the files in storage account as input feed
            
            future implementation 
            streeming Data: Azure Event Hub or Databrick Auto Loader

    Step 2: (due to time constraint I created a notebook. However, idealy it should be Spark Python job)
            Scheduled base Spark job will pull all the new data came from different sources and will perform below actions. After that it will save data Bronze Layer 
                
                1: Remove duplicate
                2: Check completeness of the data
                3: Null checks
                4: Default values
    Step 3: (due to time constraint I created a notebook. However, idealy it should be Spark Python job)
            Scheduled base Spark job will pull clean data from Bronze Layer and do the following
                
                1: Extract Fact and Dimension tables
                2: Business transformations

           
            
