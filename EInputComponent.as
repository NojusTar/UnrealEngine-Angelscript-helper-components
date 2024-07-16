class UEInputComponent : UEnhancedInputComponent
{
    UPROPERTY(Category = "Input")
    UInputAction Action;

    UPROPERTY(Category = "Input")
    UInputMappingContext ExampleContext;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        SetupEnhancedInput(ExampleContext);
        SetupInputs();
        
    }

    void SetupEnhancedInput(UInputMappingContext Context)
    {
        APlayerController PlayerController = Cast<APlayerController>(GetOwner().GetActorInstigatorController());
        UEnhancedInputLocalPlayerSubsystem EnhancedInputSubsystem = UEnhancedInputLocalPlayerSubsystem::Get(PlayerController);
        EnhancedInputSubsystem.AddMappingContext(Context, 0, FModifyContextOptions());
    }

    void SetupInputs()
    {
        BindAction(Action, ETriggerEvent::Started, FEnhancedInputActionHandlerDynamicSignature(this, n"ActionStarted"));
        BindAction(Action, ETriggerEvent::Completed, FEnhancedInputActionHandlerDynamicSignature(this, n"ActionCompleted"));
    }

    UFUNCTION()
    private void ActionCompleted(FInputActionValue ActionValue, float32 ElapsedTime,
                                 float32 TriggeredTime, const UInputAction SourceAction)
    {
        Print("Action Completed");
    }

    UFUNCTION()
    void ActionStarted(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, UInputAction SourceAction)
    {
        Print("Action Started");
    }

    
};
