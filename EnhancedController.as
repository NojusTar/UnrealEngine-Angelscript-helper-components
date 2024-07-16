class AEnhancedController : APlayerController
{
    UPROPERTY(Category = "Input")
    UInputAction Action;

    UPROPERTY(Category = "Input")
    UInputMappingContext ExampleContext;

    UPROPERTY(DefaultComponent)
    UEnhancedInputComponent EInputComponent;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        SetupEnhancedInput(ExampleContext, EInputComponent);

        SetupInputs(EInputComponent);
    }

    void SetupEnhancedInput(UInputMappingContext Context, UEnhancedInputComponent InputComponent)
    {
        PushInputComponent(InputComponent);

        UEnhancedInputLocalPlayerSubsystem EnhancedInputSubsystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
        EnhancedInputSubsystem.AddMappingContext(Context, 0, FModifyContextOptions());
    }

    void SetupInputs(UEnhancedInputComponent InputComponent)
    {
        InputComponent.BindAction(Action, ETriggerEvent::Started, FEnhancedInputActionHandlerDynamicSignature(this, n"ActionStarted"));
        InputComponent.BindAction(Action, ETriggerEvent::Completed, FEnhancedInputActionHandlerDynamicSignature(this, n"ActionCompleted"));
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
