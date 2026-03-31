#Q1
#from item table
SELECT quantityOnHand
FROM item
WHERE itemDescription = 'bottle of antibiotics';

#Q2
#from volunteer table
SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%'
AND volunteerName NOT LIKE '% Jones';

#Q3
#volunteer + assignment + task + task_type
SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment
ON volunteer.volunteerId = assignment.volunteerId
JOIN task
ON assignment.taskCode = task.taskCode
JOIN task_type
ON task.taskTypeId = task_type.taskTypeId
WHERE taskTypeName = 'transporting';

#Q4
#task + assignment
SELECT taskDescription
FROM task
LEFT JOIN assignment
ON task.taskCode = assignment.taskCode
WHERE assignment.volunteerId IS NULL;

#Q5
#package_type + package + package_contents + item
SELECT DISTINCT packageTypeName
FROM package_type
JOIN package
ON package_type.packageTypeId = package.packageTypeId
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%bottle%';

#Q6
#item + package_contents
SELECT itemDescription
FROM item
LEFT JOIN package_contents
ON item.itemId = package_contents.itemId
WHERE package_contents.packageId IS NULL;

#Q7
#task + assignment + volunteer
SELECT DISTINCT taskDescription
FROM task
JOIN assignment
ON task.taskCode = assignment.taskCode
JOIN volunteer
ON assignment.volunteerId = volunteer.volunteerId
WHERE volunteer.volunteerAddress LIKE '%NJ%';

#Q8
#volunteer + assignment
SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment
ON volunteer.volunteerId = assignment.volunteerId
WHERE startDateTime >= '2021-01-01'
AND startDateTime < '2021-07-01';

#Q9
#volunteer + assignment + task + package + package_contents + item
SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment
ON volunteer.volunteerId = assignment.volunteerId
JOIN task
ON assignment.taskCode = task.taskCode
JOIN package
ON task.taskCode = package.taskCode
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item.itemId
WHERE itemDescription = 'can of spam';

#Q10
#item + package_contents
SELECT DISTINCT itemDescription
FROM item
JOIN package_contents
ON item.itemId = package_contents.itemId
WHERE itemValue * itemQuantity = 100;

#Q11
#task_status + task + assignment
SELECT taskStatusName,
COUNT(DISTINCT assignment.volunteerId) AS numberVolunteer
FROM task_status
LEFT JOIN task
ON task_status.taskStatusId = task.taskStatusId
LEFT JOIN assignment
ON task.taskCode = assignment.taskCode
GROUP BY taskStatusName
ORDER BY numberVolunteer DESC;

#Q12
#package
SELECT taskCode,
SUM(packageWeight) AS totalWeight
FROM package
GROUP BY taskCode
ORDER BY totalWeight DESC
LIMIT 1;

#Q13
#task + task_type
SELECT COUNT(*) AS numberTask
FROM task
JOIN task_type
ON task.taskTypeId = task_type.taskTypeId
WHERE taskTypeName != 'packing';

#Q14
#item + package_contents + package + assignment
SELECT item.itemDescription
FROM item
JOIN package_contents
ON item.itemId = package_contents.itemId
JOIN package
ON package_contents.packageId = package.packageId
JOIN task
ON package.taskCode = task.taskCode
JOIN assignment
ON task.taskCode = assignment.taskCode
GROUP BY item.itemDescription
HAVING COUNT(DISTINCT volunteerId) < 3;

#Q15
#value = itemvalue*itemQuantity
#package + package_contents + item
SELECT package.packageId,
SUM(item.itemValue * package_contents.itemQuantity) AS value
FROM package
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item.itemId
GROUP BY package.packageId
HAVING SUM(item.itemValue * package_contents.itemQuantity) > 100
ORDER BY value ASC;

