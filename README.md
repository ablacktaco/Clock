# Clock

## Data Structure

![](https://i.imgur.com/UgsLQy6.png)

## AlarmViewController

* tableView: Load and display the data of alarm. Present the setting page when the editing mode.
* leftBarButtonItem(Edit/Done): Enter/leave the editing mode.
* rightBarButtonItem(+): Present the setting page.

* When the setting page is presented, send the clicking row's index of tableViewCell to setting page. If the page was presented by clicking the add button, the index is nil.

## SettingAlarmViewController

* Determine the mode is adding or editing by the index sending from the main page.
  * index == nil: Adding. Initial one basic data for tempAlarm.
  * index == indexPath.row: Editing. Assign the data having corresponding index from userDefault to tempAlarm
* Choose the state of snoozing and the time u want the alarm work
* tableView: Display the state of repeating, label, sound, snoozing and present the corresponding setting page when the tableViewCell is clicking.
* leftBarButtonItem(Cancel): Back to the main page.
* rightBarButtonItem(Save): Back to the main page and do the things below.
  * Adding mode: Append the new data(tempAlarm) in the AlarmData array.
  * Editing mode: Update the new data(tempAlarm) to the AlarmData having corresponding index.

## SettingRepeatViewController

* Choose the repeating day.
* Save the repeating day to tempAlarm

## SettingLabelViewController

* Set the label of alarm
* Save the label to tempAlarm

## Demo

![](https://i.imgur.com/u5He1sM.gif)

## Next to Do

* Sort
* Sound(Repeating)
* Notification
