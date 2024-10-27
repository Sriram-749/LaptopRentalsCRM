@isTest
private class LaptopBookingHandlerTest {
    @isTest
    static void testSendEmailNotification() {
        consumer__c consumer = new consumer__c(
            Name = 'John Doe',
            Phone_number__c = '9887346134',
            Address__c = 'Paris, France',
            Email__c = 'johndoe@example.com',
            consumer_Status__c = 'Student'
        );
        insert consumer;
        System.debug('Consumer Id: ' + consumer.Id);
        Total_Laptops__c totalLaptops = new Total_Laptops__c(
            Name = '1'
        );
        insert totalLaptops;
        List<Laptop_Bookings__c> lapBookings = new List<Laptop_Bookings__c>();
        lapBookings.add(new Laptop_Bookings__c(
            Name = 'Booking11',
            Email__c = consumer.Email__c,
            Name__c = consumer.Id,
            Amount__c = 900,
            core_type__c = 'core i3',
            Laptop_names__c = 'Dell',
            Total_No_Of_Laptops__c = totalLaptops.Id,
            How_Many_Months__c = '1'
        ));
        insert lapBookings;
        Test.startTest();
        LaptopBookingHandler.sendEmailNotification(lapBookings);
        Test.stopTest();
        Integer sentEmailCount = Limits.getEmailInvocations();
        System.assertEquals(2, sentEmailCount, 'Two emails should have been sent.');
    }
}