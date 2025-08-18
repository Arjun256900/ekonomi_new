
abstract class AddEventEvent  {
}

class TitleChanged extends AddEventEvent {
  final String title;
   TitleChanged(this.title);

  
}

class DateChanged extends AddEventEvent {
  final String date;
   DateChanged(this.date);


}

class BudgetChanged extends AddEventEvent {
  final String budget;
   BudgetChanged(this.budget);

}

class SavingStrategyChanged extends AddEventEvent {
  final String strategy;
   SavingStrategyChanged(this.strategy);

 
}

class LinkToGoalChanged extends AddEventEvent {
  final String? option; // Yes / No
   LinkToGoalChanged(this.option);

  
}

class ReminderToggled extends AddEventEvent {}

class SaveEventPressed extends AddEventEvent {}
