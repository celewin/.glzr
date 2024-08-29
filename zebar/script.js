export function focusWorkspace(event, context) {
  console.log('Focus button clicked!', event, context);
  const id = event.target.id;
  context.providers.glazewm.focusWorkspace(id);
};

export function startCmd(event, context) {
  console.log(context.providers.glazewm)
  //context.providers.glazewm.currentWorkspace
}