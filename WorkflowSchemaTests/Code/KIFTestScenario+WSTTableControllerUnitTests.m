//
//  KIFTestScenario+WSTTableControllerUnitTests.m
//  WorkflowSchemaTests
//
//  Created by Simon Booth on 26/10/2012.
//  Copyright (c) 2012 CRedit360. All rights reserved.
//

#import "KIFTestScenario+WSTTableControllerUnitTests.h"
#import "KIFTestStep+WSTShared.h"
#import "WSTAssert.h"
#import "WSTTestAction.h"
#import "WSTTestContext.h"

@implementation KIFTestScenario (WSTTableControllerUnitTests)

+ (id)scenarioUnitTestCreateTableWithImplicitSectionsAndCells
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test table controller with implicit sections"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:@[
                                      [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"1a"]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"1b"]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"1c"]]
                                      ]],
                                      [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                           [[WFSSchemaParameter alloc] initWithName:@"headerTitle" value:@[@"section 2 header"]],
                                           [[WFSSchemaParameter alloc] initWithName:@"cells" value:@[
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2a"]],
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2b"]],
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2c"]],
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2d"]]
                                            ]],
                                           [[WFSSchemaParameter alloc] initWithName:@"footerTitle" value:@[@"section 2 footer"]],
                                      ]]
                                 ]];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTFailOnError(error);
        WSTAssert([tableController isKindOfClass:[WFSTableController class]]);
        UITableView *tableView = tableController.tableView;
        
        // These we can test directly
        WSTAssert([tableView numberOfSections] == 2);
        WSTAssert([tableView numberOfRowsInSection:0] == 3);
        WSTAssert([tableView numberOfRowsInSection:1] == 4);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        WSTAssert([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqual:@"2c"]);
        
        // The rest we can only test through the delegate (on iOS 5, anyway)
        WSTAssert(tableView.delegate == tableController);
        WSTAssert(tableView.dataSource == tableController);
        
        WSTAssert([[tableController tableView:tableView titleForHeaderInSection:1] isEqual:@"section 2 header"]);
        WSTAssert([[tableController tableView:tableView titleForFooterInSection:1] isEqual:@"section 2 footer"]);
        
        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}

+ (id)scenarioUnitTestCreateTableWithExplicitSectionsAndCells
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test table controller with explicit sections"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:@[
                                      [[WFSSchemaParameter alloc] initWithName:@"sections" value:@[
                                          [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"1a"]],
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"1b"]],
                                               [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"1c"]]
                                          ]],
                                          [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                               [[WFSSchemaParameter alloc] initWithName:@"headerTitle" value:@[@"section 2 header"]],
                                               [[WFSSchemaParameter alloc] initWithName:@"cells" value:@[
                                                    [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2a"]],
                                                    [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2b"]],
                                                    [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2c"]],
                                                    [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"2d"]]
                                               ]],
                                               [[WFSSchemaParameter alloc] initWithName:@"footerTitle" value:@[@"section 2 footer"]],
                                          ]]
                                      ]]
                                 ]];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTFailOnError(error);
        WSTAssert([tableController isKindOfClass:[WFSTableController class]]);
        UITableView *tableView = tableController.tableView;
        
        // These we can test directly
        WSTAssert([tableView numberOfSections] == 2);
        WSTAssert([tableView numberOfRowsInSection:0] == 3);
        WSTAssert([tableView numberOfRowsInSection:1] == 4);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        WSTAssert([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqual:@"2c"]);
        
        // The rest we can only test through the delegate (on iOS 5, anyway)
        WSTAssert(tableView.delegate == tableController);
        WSTAssert(tableView.dataSource == tableController);
        
        WSTAssert([[tableController tableView:tableView titleForHeaderInSection:1] isEqual:@"section 2 header"]);
        WSTAssert([[tableController tableView:tableView titleForFooterInSection:1] isEqual:@"section 2 footer"]);
        
        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}

+ (id)scenarioUnitTestCreateTableWithoutSections
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test table controller without sections"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:nil];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTAssert(tableController == nil);
        WSTAssert(error != nil);
        
        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}

+ (id)scenarioUnitTestCreateTableWithActions
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test table controller with cell properties and actions"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:@[
                                      [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"actionName" value:@"didSelectCellA"],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@"1a"],
                                           ]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"actionName" value:@"didSelectCellB"],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@"1b"],
                                           ]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"accessoryType" value:@"detailDisclosureIndicatorButton"],
                                                [[WFSSchemaParameter alloc] initWithName:@"actionName" value:@"didSelectCellC"],
                                                [[WFSSchemaParameter alloc] initWithName:@"detailDisclosureActionName" value:@"didSelectCellCAccessory"],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@"1c"],
                                           ]],
                                      ]],
                                      [[WFSSchemaParameter alloc] initWithName:@"actions" value:@[
                                          [[WFSSchema alloc] initWithTypeName:@"testAction" attributes:@{@"name":@"didSelectCellA"} parameters:nil],
                                          [[WFSSchema alloc] initWithTypeName:@"testAction" attributes:@{@"name":@"didSelectCellC"} parameters:nil],
                                          [[WFSSchema alloc] initWithTypeName:@"testAction" attributes:nil parameters:nil]
                                      ]]
                                  ]];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTFailOnError(error);
        WSTAssert([tableController isKindOfClass:[WFSTableController class]]);
        
        UITableView *tableView = tableController.tableView;
        WSTAssert(tableView.delegate == tableController);
        WSTAssert(tableView.dataSource == tableController);
        
        WSTAssert(tableController.actions.count == 3)
        
        WSTAssert([tableView numberOfSections] == 1);
        WSTAssert([tableView numberOfRowsInSection:0] == 3);
        
        NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableController tableView:tableView didSelectRowAtIndexPath:indexPathA];
        // the first action's name (didSelectCellA) matches the actionName of the cell (didSelectCellA) so it fires
        WSTAssert([WSTTestAction lastTestAction] == tableController.actions[0]);
        
        NSIndexPath *indexPathB = [NSIndexPath indexPathForRow:1 inSection:0];
        [tableController tableView:tableView didSelectRowAtIndexPath:indexPathB];
        // the first action's name (didSelectCellA) does not match the actionName of the cell (didSelectCellB)
        // the second action's pattern (didSelectCellC) does not match the actionName of the cell (didSelectCellB)
        // the third action has no name so it fires as a default
        WSTAssert([WSTTestAction lastTestAction] == tableController.actions[2]);
        
        NSIndexPath *indexPathC = [NSIndexPath indexPathForRow:2 inSection:0];
        [tableController tableView:tableView didSelectRowAtIndexPath:indexPathC];
        // the first action's name (didSelectCellA) does not match the actionName of the cell (didSelectCellC)
        // the second action's name (didSelectCellC) matches the actionName of the cell (didSelectCellC) so it fires
        WSTAssert([WSTTestAction lastTestAction] == tableController.actions[1]);
        
        [tableController tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPathC];
        // the first action's name (didSelectCellA) does not match the detailDisclosureActionName of the cell (didSelectCellCAccessory)
        // the second action's pattern (didSelectCellC) does match the detailDisclosureActionName of the cell (didSelectCellCAccessory)
        // the third action has no pattern so it fires as a default
        WSTAssert([WSTTestAction lastTestAction] == tableController.actions[2]);
        
        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}

+ (id)scenarioUnitTestCreateTableWithStyles
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test table controller with styles"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:@[
                                      [[WFSSchemaParameter alloc] initWithName:@"style" value:@[@"grouped"]],
                                      [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"style" value:@[@"default"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@[@"1a"]],
                                            ]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"style" value:@[@"subtitle"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@[@"1b"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"detailText" value:@[@"1b detail"]],
                                            ]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"style" value:@[@"value1"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@[@"1c"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"detailText" value:@[@"1c detail"]],
                                            ]],
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"style" value:@[@"value2"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"text" value:@[@"1d"]],
                                                [[WFSSchemaParameter alloc] initWithName:@"detailText" value:@[@"1d detail"]],
                                            ]]
                                       ]],
                                  ]];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTFailOnError(error);
        WSTAssert([tableController isKindOfClass:[WFSTableController class]]);
        UITableView *tableView = tableController.tableView;
        WSTAssert(tableView.style == UITableViewStyleGrouped);
        
        // These we can test directly
        WSTAssert([tableView numberOfSections] == 1);
        WSTAssert([tableView numberOfRowsInSection:0] == 4);
        
        NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:0 inSection:0];
        WFSTableCell *cellA = (WFSTableCell *)[tableView cellForRowAtIndexPath:indexPathA];
        WSTAssert([cellA isKindOfClass:[WFSTableCell class]]);
        WSTAssert(cellA.style == UITableViewCellStyleDefault);
        WSTAssert([cellA.textLabel.text isEqual:@"1a"]);
        
        NSIndexPath *indexPathB = [NSIndexPath indexPathForRow:1 inSection:0];
        WFSTableCell *cellB = (WFSTableCell *)[tableView cellForRowAtIndexPath:indexPathB];
        WSTAssert([cellB isKindOfClass:[WFSTableCell class]]);
        WSTAssert(cellB.style == UITableViewCellStyleSubtitle);
        WSTAssert([cellB.textLabel.text isEqual:@"1b"]);
        WSTAssert([cellB.detailTextLabel.text isEqual:@"1b detail"]);
        
        NSIndexPath *indexPathC = [NSIndexPath indexPathForRow:2 inSection:0];
        WFSTableCell *cellC = (WFSTableCell *)[tableView cellForRowAtIndexPath:indexPathC];
        WSTAssert([cellC isKindOfClass:[WFSTableCell class]]);
        WSTAssert(cellC.style == UITableViewCellStyleValue1);
        WSTAssert([cellC.textLabel.text isEqual:@"1c"]);
        WSTAssert([cellC.detailTextLabel.text isEqual:@"1c detail"]);
        
        NSIndexPath *indexPathD = [NSIndexPath indexPathForRow:3 inSection:0];
        WFSTableCell *cellD = (WFSTableCell *)[tableView cellForRowAtIndexPath:indexPathD];
        WSTAssert([cellD isKindOfClass:[WFSTableCell class]]);
        WSTAssert(cellD.style == UITableViewCellStyleValue2);
        WSTAssert([cellD.textLabel.text isEqual:@"1d"]);
        WSTAssert([cellD.detailTextLabel.text isEqual:@"1d detail"]);

        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}

+ (id)scenarioUnitTestTablesHandleMessages
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test table controller handles 'table' messages and passes on others"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:@[
                                      [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"Text"]]
                                      ]],
                                      [[WFSSchemaParameter alloc] initWithName:@"actions" value:@[
                                           [[WFSSchema alloc] initWithTypeName:@"testAction" attributes:@{@"name":@"test"} parameters:nil],
                                           [[WFSSchema alloc] initWithTypeName:@"testAction" attributes:nil parameters:nil]
                                      ]]
                                 ]];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTFailOnError(error);
        WSTAssert([tableController isKindOfClass:[WFSTableController class]]);
        WSTAssert(tableController.actions.count == 2);
        
        WSTTestAction *firstAction = tableController.actions[0];
        WSTTestAction *secondAction = tableController.actions[1];
        
        WFSContext *messageContext = [WFSContext contextWithDelegate:tableController];
        
        WFSMessage *firstMessage = [WFSMessage messageWithType:@"table" name:@"test" context:messageContext responseHandler:nil];
        [messageContext sendWorkflowMessage:firstMessage];
        WSTAssert([WSTTestAction lastTestAction] == firstAction);
        
        WFSMessage *secondMessage = [WFSMessage messageWithType:@"table" name:@"different name" context:messageContext responseHandler:nil];
        [messageContext sendWorkflowMessage:secondMessage];
        WSTAssert([WSTTestAction lastTestAction] == secondAction);
        
        WSTAssert([context.messages isEqualToArray:@[]]);
        
        WFSMessage *thirdMessage = [WFSMessage messageWithType:@"different type" name:@"test" context:messageContext responseHandler:nil];
        [messageContext sendWorkflowMessage:thirdMessage];
        
        WSTAssert([context.messages isEqualToArray:@[ thirdMessage ]]);
        
        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}


+ (id)scenarioUnitTestSendTableMessageFromTable
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that 'table' messages sent by a table go up a level"];
    
    [scenario addStep:[KIFTestStep stepWithDescription:scenario.description executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **outError) {
        
        NSError *error = nil;
        
        WFSSchema *tableSchema = [[WFSSchema alloc] initWithTypeName:@"table" attributes:nil parameters:@[
                                      [[WFSSchema alloc] initWithTypeName:@"tableSection" attributes:nil parameters:@[
                                           [[WFSSchema alloc] initWithTypeName:@"tableCell" attributes:nil parameters:@[ @"Text"]]
                                      ]],
                                      [[WFSSchemaParameter alloc] initWithName:@"actions" value:@[
                                           [[WFSSchema alloc] initWithTypeName:@"sendMessage" attributes:@{@"name":@"test1"} parameters:@[
                                                [[WFSSchemaParameter alloc] initWithName:@"messageType" value:@"table"],
                                                [[WFSSchemaParameter alloc] initWithName:@"messageName" value:@"test2"]
                                           ]]
                                      ]]
                                 ]];
        
        WSTTestContext *context = [[WSTTestContext alloc] init];
        
        WFSTableController *tableController = (WFSTableController *)[tableSchema createObjectWithContext:context error:&error];
        WSTFailOnError(error);
        WSTAssert([tableController isKindOfClass:[WFSTableController class]]);
        
        [tableController.tableView reloadData];
        WFSTableCell *tableCell = (WFSTableCell *)[tableController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        
        WFSMessage *messageGoingIn = [WFSMessage messageWithType:@"table" name:@"test1" context:tableCell.workflowContext responseHandler:nil];
        [tableCell.workflowContext sendWorkflowMessage:messageGoingIn];
        WSTAssert(context.messages.count == 1);
        WFSMessage *messageComingOut = context.messages[0];
        WSTAssert([messageComingOut.type isEqual:@"table"]);
        WSTAssert([messageComingOut.name isEqual:@"test2"]);
        
        return KIFTestStepResultSuccess;
        
    }]];
    
    return scenario;
}

@end